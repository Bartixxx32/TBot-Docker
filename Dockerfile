FROM mcr.microsoft.com/dotnet/sdk:5.0 as builder
RUN git clone --recursive https://github.com/ogame-tbot/TBot
WORKDIR TBot
RUN dotnet publish -c Release -r linux-arm64 -o publish/linuxarm64/ -p:PublishSingleFile=true --self-contained false

FROM golang:1.16.3
COPY --from=0 /TBot /TBot
WORKDIR /TBot/ogame/cmd/ogamed
RUN env GOOS=linux GOARCH=arm64 go build -o ogamed
RUN cp -r /TBot/ogame/cmd/ogamed/ogamed /TBot/publish/linuxarm64

#FROM mcr.microsoft.com/dotnet/sdk:5.0
FROM mcr.microsoft.com/dotnet/runtime:5.0
COPY --from=1 /TBot/publish/linuxarm64 /app/TBot
WORKDIR /app/TBot
ENTRYPOINT ["./TBot"]
