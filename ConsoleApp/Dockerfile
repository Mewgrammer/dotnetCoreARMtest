FROM mcr.microsoft.com/dotnet/core/runtime:3.0-buster-slim AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY ["ConsoleApp.csproj", ""]
RUN dotnet restore "./ConsoleApp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "ConsoleApp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "ConsoleApp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ConsoleApp.dll"]