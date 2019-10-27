# start the application
```bash
./bootstrap.sh
```

# get expenses
```bash
curl http://localhost:5000/expenses
```

# add a new expense
```bash
curl -X POST -H "Content-Type: application/json" -d '{
    "amount": 20,
    "description": "lottery ticket"
}' http://localhost:5000/expenses
```

# get incomes
```bash
curl http://localhost:5000/incomes
```

# add a new income
```bash
curl -X POST -H "Content-Type: application/json" -d '{
    "amount": 300.0,
    "description": "loan payment"
}' http://localhost:5000/incomes
```

