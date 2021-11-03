#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["AV.PublicWikiAccess/AV.PublicWikiAccess.csproj", "AV.PublicWikiAccess/"]
RUN dotnet restore "AV.PublicWikiAccess/AV.PublicWikiAccess.csproj"
COPY . .
WORKDIR "/src/AV.PublicWikiAccess"
RUN dotnet build "AV.PublicWikiAccess.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "AV.PublicWikiAccess.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AV.PublicWikiAccess.dll"]