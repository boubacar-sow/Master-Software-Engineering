## Part 3: Multi-Service Application
Let's build a Node.js app with a MongoDB database

### 3.1 Directory & Files
```bash
mkdir -p docker-compose/multi-service-app
cd docker-compose/multi-service-app
```
- app.js (Node server)
- Dockerfile for the app
- docker-compose.yml

### 3.1.1. `app.js``
```js
// docker-compose/multi-service-app/app.js
const express = require('express');
const { MongoClient } = require('mongodb');
const app = express();
const PORT = process.env.PORT || 3000;
const MONGO_URL = process.env.MONGO_URL || 'mongodb://mongo:27017';
const DB_NAME = 'demo';

app.get('/', async (req, res) => {
  const client = new MongoClient(MONGO_URL);
  await client.connect();
  const db = client.db(DB_NAME);
  const count = await db.collection('visits').countDocuments();
  await db.collection('visits').insertOne({ time: new Date() });
  res.send(`Hello! You are visitor #${count + 1}`);
  await client.close();
});

app.listen(PORT, () => console.log(`App on port ${PORT}`));
``` 
### 3.1.2. Dockerfile
```dockerfile
# docker-compose/multi-service-app/Dockerfile
FROM node:18-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
COPY app.js ./
EXPOSE 3000
CMD ["node", "app.js"]
```
Create a package.json:
```json
{
  "name": "compose-demo",
  "version": "1.0.0",
  "main": "app.js",
  "dependencies": {
    "express": "^4.18.2",
    "mongodb": "^5.3.0"
  }
}
```
### 3.1.3. `docker-compose.yml`
```yaml
version: "3.9"
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - MONGO_URL=mongodb://mongo:27017
    depends_on:
      - mongo

  mongo:
    image: mongo:6.0
    volumes:
      - mongo-data:/data/db

volumes:
  mongo-data:
```

### 3.2. Launch the Stack

```docker compose up --build```

- Compose builds the app image, then starts mongo and app.

- ```depends_on``` ensures ```mongo``` container starts first (does not wait for “ready”).

Visit http://localhost:3000 repeatedly to see the visit counter increment.

Tear down:

docker compose down -v

- ```-v``` removes named volumes (```mongo-data```), resetting the database.

## Part 4: Advanced Compose Features
### 4.1. Scaling Services

You can scale stateless services:

```docker compose up --scale app=3```

This spins up 3 replicas of ```app``` (on different ephemeral ports by default).
Useful for load‑testing or local high‑availability.
4.2. Override Files

Use ```docker-compose.override.yml``` to customize per‑environment:

# docker-compose.override.yml
services:
  app:
    environment:
      - NODE_ENV=development
    volumes:
      - ./:/usr/src/app   # mount code for live reload

Compose automatically merges ```docker-compose.yml``` and ```docker-compose.override.yml```.
4.3. Custom Networks

By default, Compose creates a network. You can define one:
```yaml
networks:
  frontend:
  backend:
services:
  app:
    networks:
      - frontend
      - backend
  mongo:
    networks:
      - backend
```
This isolates direct traffic: only services on ```backend``` can reach Mongo.
### 4.4. Multiple Compose Files

Combine multiple files with -f:
```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml up
```

Override or extend definitions for production, testing, or CI.
## Part 5: Useful Commands & Tips

| Command                                   | Description                                          |
|-------------------------------------------|------------------------------------------------------|
| `docker compose up --build`              | Build (if needed) and start all services             |
| `docker compose down -v`                 | Stop and remove containers, networks, and volumes    |
| `docker compose logs -f [service]`       | Follow logs for all or a specific service            |
| `docker compose ps`                      | List running services and ports                      |
| `docker compose exec [service] sh`       | Run a shell inside a running container               |
| `docker compose run --rm [service] cmd`  | Run a one‑off command against a service              |


> **Tip**: Use docker compose config to view the fully rendered configuration after merging overrides and environment variables.