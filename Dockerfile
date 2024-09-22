# Stage 1: Build the application
FROM node:latest AS builder

# Set the working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./

RUN npm install

# Copy the rest of the application code
COPY . .

# Build the NestJS application
RUN npm run build

# Stage 2: Run the application
FROM node:20.14.0-alpine

# Set the working directory
WORKDIR /app

RUN addgroup -S dockeruser && adduser -S -G dockeruser dockeruser

# Copy the built application from the builder stage
COPY --chown=dockeruser:dockeruser --from=builder /app/node_modules /app/node_modules
COPY --chown=dockeruser:dockeruser --from=builder /app/dist /app/dist
COPY --chown=dockeruser:dockeruser --from=builder /app/package.json /app

# Expose the application port
EXPOSE 3000

ENTRYPOINT [ "npm" ]
# Start the application
CMD ["run","start:prod"]
