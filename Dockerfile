# Establece la imagen base de .NET para compilar la aplicación
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

# Copia el archivo del proyecto y restaura las dependencias
COPY TodoApi.csproj ./
RUN dotnet restore

# Copia el resto de los archivos del proyecto
COPY . ./

# Compila la aplicación
RUN dotnet publish -c Release -o out

# Establece la imagen base para el contenedor de producción
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app

# Copia los archivos publicados de la etapa de compilación
COPY --from=build-env /app/out .

# Establece las variables de entorno
ENV ASPNETCORE_URLS=http://+:80

# Expone el puerto en el que se ejecuta la API
EXPOSE 80

# Ejecuta la aplicación
ENTRYPOINT ["dotnet", "TodoApi.dll"]
