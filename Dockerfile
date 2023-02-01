FROM  mcr.microsoft.com/dotnet/sdk as build-env
WORKDIR /app
COPY *.csproj ./
#COPY ./nuget.config ./
#COPY daemon.json ./
#RUN dotnet restore --interactive
RUN dotnet restore TodoApi.csproj 
##--configfile ./nuget.config
COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet 
WORKDIR /app
COPY --from=build-env /app/out .
# COPY c035.db ./
ENTRYPOINT ["dotnet", "TodoApi.dll"]