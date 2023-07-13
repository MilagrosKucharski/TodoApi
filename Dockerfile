FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copia los archivos del proyecto
COPY . .

# Restaura las dependencias y compila el proyecto
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Configura el punto de entrada de la aplicación
ENTRYPOINT ["dotnet", "out/TodoApi.dll"]
