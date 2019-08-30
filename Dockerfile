FROM nginx:alpine

#Add index.html
COPY index.html /usr/share/nginx/html

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/
RUN mkdir /etc/nginx/logs

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Create a runner script for the entrypoint
COPY runner.sh /runner.sh && RUN chmod +x /runner.sh

# Expose ports
EXPOSE 80

ENTRYPOINT ["/runner.sh"]


