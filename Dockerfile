FROM openresty/openresty:alpine
LABEL maintainer "joeyw <joeyw@reallyenglish.com>"

RUN apk add --no-cache curl perl
RUN opm get leafo/pgmoon \
    && opm get lua-resty-session


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
