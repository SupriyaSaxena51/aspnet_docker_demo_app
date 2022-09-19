FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app
#Copy the CSPROJ files 
COPY *.csproj ./
#Restore all the dependencies (via NUGET)
RUN dotnet restore
#Copy everything else and build 
COPY  . ./
RUN dotnet publish -c  Release -o out

#Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "aspnet_docker_demo_app.dll"]