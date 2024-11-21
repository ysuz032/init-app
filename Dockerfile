FROM public.ecr.aws/nginx/nginx:stable

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080
EXPOSE 5000
