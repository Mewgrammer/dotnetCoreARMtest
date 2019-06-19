FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY ["MvcApp.csproj", "MvcApp/"]
RUN dotnet restore "MvcApp.csproj"
COPY . .
WORKDIR "/src/MvcApp"
RUN dotnet build "MvcApp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "MvcApp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "MvcApp.dll"]