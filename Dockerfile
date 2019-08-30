FROM nginx:alpine

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/
RUN mkdir /etc/nginx/logs && RUN mkdir /www/data

#Add index.html
COPY index.html /www/data

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Create a runner script for the entrypoint
COPY runner.sh /runner.sh && RUN chmod +x /runner.sh

# Expose ports
EXPOSE 80

ENTRYPOINT ["/runner.sh"]


