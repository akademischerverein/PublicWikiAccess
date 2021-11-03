#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["AV.PublicWikiAccess.sln", "./"]
COPY ["src/Directory.Build.props", "src/"]
COPY ["src/AV.PublicWikiAccess/AV.PublicWikiAccess.csproj", "src/AV.PublicWikiAccess/"]
RUN dotnet restore "AV.PublicWikiAccess.sln"
COPY . .
RUN dotnet build "AV.PublicWikiAccess.sln" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "src/AV.PublicWikiAccess/AV.PublicWikiAccess.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AV.PublicWikiAccess.dll"]
