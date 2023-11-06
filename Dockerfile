# Use the official Ruby image as a parent image
FROM ruby:3.0.2

# Set the working directory within the container
WORKDIR /app

# Copy Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install any needed gems
RUN bundle install

COPY . .

# Expose port 3000 to the host
EXPOSE 3000

# Start your application
CMD ["rails", "server", "-b", "0.0.0.0"]
