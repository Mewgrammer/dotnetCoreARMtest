FROM mcr.microsoft.com/dotnet/core-nightly/aspnet:3.0.0-preview5 AS base
WORKDIR /app
EXPOSE 80	
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core-nightly/sdk:3.0.100-preview5 AS build
WORKDIR /src
COPY . .
RUN dotnet restore "NetCoreArmTest.csproj"
RUN dotnet build "NetCoreArmTest.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "NetCoreArmTest.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "NetCoreArmTest.dll"]
