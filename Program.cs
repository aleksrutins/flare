using GraphQL;
using Flare.GQL;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddGraphQL(b => b
    .AddAutoSchema<Schema>()
    .AddSystemTextJson());


// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseWebSockets();
app.UseGraphQL();
app.UseGraphQLGraphiQL();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseAuthorization();

app.MapControllers();

app.Run();
