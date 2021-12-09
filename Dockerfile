FROM ubuntu:latest

COPY hello.sh ~/hello.sh

CMD ["/bin/bash", "~/hello.sh"]
