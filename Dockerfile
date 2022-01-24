FROM mcr.microsoft.com/dotnet/sdk:5.0 as builder
RUN git clone https://github.com/ogame-tbot/TBot
WORKDIR TBot
RUN dotnet publish -c Release -r linux-arm64 -o publish/linuxarm64/ -p:PublishSingleFile=true --self-contained false

FROM mcr.microsoft.com/dotnet/sdk:5.0 
COPY --from=0 /TBot/publish/linuxarm64 /app/TBot
WORKDIR /app/TBot
RUN ls
