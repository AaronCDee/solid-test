# syntax=docker/dockerfile:1

FROM oven/bun:1

RUN useradd --create-home --home-dir=/app app
RUN mkdir /node_modules && chown app:app /node_modules

USER app
WORKDIR /app

COPY package.json bun.lockb ./

RUN bun install --frozen-lockfile --production

COPY . /app

# See package.json for build script
RUN NODE_ENV=production bun run build

CMD [ "/bin/bash", "boot_solid_start" ]
