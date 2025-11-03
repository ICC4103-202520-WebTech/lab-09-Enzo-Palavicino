# syntax=docker/dockerfile:1

# Imagen base Ruby para producción
FROM ruby:3.2-slim AS base

WORKDIR /app

# Dependencias de sistema para Rails + activos
RUN apt-get update -qq \
 && apt-get install --no-install-recommends -y build-essential curl git libpq-dev nodejs npm postgresql-client \
 && npm install --global yarn \
 && rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/bundle \
    BUNDLE_WITHOUT=development:test

FROM base AS build

COPY Gemfile Gemfile.lock ./
RUN bundle config set --local path "$BUNDLE_PATH" \
 && bundle config set --local without 'development test' \
 && bundle install

COPY package.json yarn.lock ./
RUN if [ -f package.json ]; then yarn install --frozen-lockfile; fi

COPY . .

RUN bundle exec bootsnap precompile --gemfile || true
RUN SECRET_KEY_BASE=dummy bundle exec rake assets:precompile

FROM base AS production

COPY --from=build /bundle /bundle
COPY --from=build /app /app

ENV RAILS_SERVE_STATIC_FILES=1 \
    RAILS_LOG_TO_STDOUT=1 \
    PORT=3000

EXPOSE 3000

# Ejecuta Puma escuchando en 0.0.0.0
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb", "-b", "tcp://0.0.0.0:3000"]
