Docker front:
    -build dev:
        - docker build -f App/front/Dockerfile.dev -t angular-dev App/front
    -run dev:
        - docker run -it --rm -p 4200:4200 -v $(pwd)/App/front:/app angular-dev
    -build prod:
        - docker build -f App/front/Dockerfile.prod -t angular App/front
    -run prod:
        - docker run -d -p 80:80 angular

Docker back:
    -build:
        -docker build -f App/back/Dockerfile.dev -t node-back App/back
    -run:
        -docker run -it --rm -p 3000:3000 -v $(pwd)/App/back:/app node-back

Docker bdd:
    -build:
        -docker build --no-cache -t postgres-bdd App/bdd
    -run:
        -docker run --name bdd -p 5432:5432 -v $(pwd)/App/bdd/data:/var/lib/postgresql/data bdd

Lancement dev:
    docker compose -f docker-compose.dev.yml up -d --build

Lancement prod:
    docker compose -f docker-compose.prod.yml up -d --build