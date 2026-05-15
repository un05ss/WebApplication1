FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY WebApplication1.sln .
COPY WebApplication1/*.csproj ./WebApplication1/
RUN dotnet restore

COPY . .
WORKDIR /app/WebApplication1
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
