# Exercise - API Contracts

### Version elixir and erlang (You can install using ASDF)
* elixir 1.10.4-otp-23
* erlang 23.1.1



### Libraries
* Phoenix 1.4.9
* Absinthe 1.4

### Database
* Mysql
## Config:
* Set your config database in config/dev.exs and config/test.exs


To start your server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`
  * Run unit tests `mix test`

Now you can visit Graphiql Playground to test and see the queries and mutations [`localhost:4000/graphiql`](http://localhost:4000/graphiql) from your browser.

## Github [Actions](https://github.com/brunodeveloper/exercise/actions)
* `.github/workflows/elixir.yml`

# Graphql

## Queries

* list contracts
```
    query{
      listContracts {
      id
      name
      date
      description
      filePath
      legalEntities {
          id
          address
          city
          cnpj
          country
          state
          zipCode
        }
        physicalPersons{
          id
          name
          cpf
          birthdate
        }
      }
    }
```

* list contracts with filter - You can use the date and entity together or just one


```
query{
      listContracts(date:"2021-01-10", entityId: 1) {
      id
      name
      date
      description
      filePath
      legalEntities {
          id
          address
          city
          cnpj
          country
          state
          zipCode
        }
        physicalPersons{
          id
          name
          cpf
          birthdate
        }
      }
    }

```

* list physical persons

```
    query{
      listPhysicalPersons {
        id
        name
        cpf
        birthdate
      }
    }
```

* list legal entities

```
query{
    listLegalEntities {
      id
      name
      cnpj
      country
      state
      city
      address
      zipCode
    }
  }
```

## Mutations

* create Physical Person

```
mutation ($input: PhysicalPersonInput) {
  createPhysicalPerson(input: $input) {
    id
  }
}

#Example variables
{
  "input": 
    {
    "name": "teste6",
    "cpf": "9876543",
    "birthdate": "1980-11-01"
    } 
}

```


* create legal entity

```
mutation ($input: LegalEntityInput) {
  createLegalEntity(input: $input) {
    id
  }
}

#Example variables
{
  "input": {
  	"name": "EMPRESA TESTE",
  	"cnpj":"9876543",
  	"country": "BR", 
    "city": "RIO DE JANEIRO",
    "state": "RJ",
  	"address": "TESTE",
		"zipCode": "1234"
	} 
}
```

* create contract

```
mutation ($input: ContractInput) {
  createContract(input: $input) {
    id
  }
}

#Example variables
{
  "input": {
  	"date" :"2020-02-03",
  	"description": "descricao aqui",
  	"name": "nome do contrato",
  	"filePath": "arquivo.pdf",
    "entities":[1,2,3]
	}
}
```
