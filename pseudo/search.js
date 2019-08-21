//would do some sort of @wire and save to a array

cust = []

const search = (array, query) =>{
    return this.array.filter(x => 
        x.toLowerCase().indexOf(query.toLowerCase()) == -1)
}

const searchCust=(e=> search(this.cust, e.target.value))