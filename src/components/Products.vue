<template>
  <div class="Products">
    <md-layout md-gutter="8">
      <md-layout md-flex>
        <md-input-container id="pr_name">
          <label>Product Name:</label>
          <md-input v-model="pr_name" placeholder="Type the product's name" required></md-input>
        </md-input-container>
      </md-layout>
      <md-layout md-flex-medium="20">
        <md-button id="add_product" v-on:click="addProduct(pr_name,9.99)" class="md-icon-button md-raised md-accent">
          <md-icon>add</md-icon>
        </md-button>
      </md-layout>
    </md-layout>
    <md-list v-if="products">
      <md-list-item v-for="product in products">
        <md-avatar>
          <img :src="'https://placeimg.com/40/40/people/' + product.node.prId" alt="People">
        </md-avatar>

        <span>{{product.node.prId}} - {{product.node.prJsonb.pr_name}} - {{product.node.prJsonb.pr_price}}</span>

        <md-button v-on:click="removeProduct(product.node.prId, product.node.prJsonb)" class="md-icon-button md-list-action">
          <md-icon class="md-primary">remove_circle</md-icon>
        </md-button>
      </md-list-item>
    </md-list>
  </div>
</template>

<script>
export default {
  data () {
    return {
      pr_name: null,
      products:[]
    }
  },
  mounted() {
    this.getProducts();
  },
  methods: {
    getProducts: function() {
      this.$http.post('http://localhost:5000/graphql', 
      {"query": 
      `{
        searchProducts {
          edges {
            node {
              prId
              prJsonb
              prUpdatedate
              prCreateddate
            }
          }
        }
      }`
    }).then((response) => {
        console.log(response.body);
         this.products =  response.body.data.searchProducts.edges;
      }, (response) => {
        // error callback
         console.log(response);        
      });
    }, 
    addProduct: function(pr_name, pr_price) {
      if(pr_name === null || pr_name.length === 0) {
        alert('The product name cannot be empty');
        return;
      }
      this.$http.post('http://localhost:5000/graphql', 
      {"query": 
      `mutation newProduct($input: CreateProductInput!) {
        createProduct(input: $input) {
          clientMutationId
          product {
            prId
            prJsonb
          }
        }
      }`,
      "variables":{
        "input":{
          "clientMutationId": pr_name,
          "product": {
            "prJsonb": {"pr_name":pr_name,"pr_price":pr_price,"pr_status":"A","pr_description":"Test Product"}
          }
        }
      }
    }).then((response) => {
        console.log(response);
         this.getProducts();
      }, (response) => {
        // error callback
         console.log(response);        
      });
    },
    removeProduct: function(pr_id, pr_jsonb) {
      console.log(pr_jsonb)
      pr_jsonb.pr_status = "I";
      this.$http.post('http://localhost:5000/graphql', 
      {"query": 
      `mutation updateProduct($input: UpdateProductByPrIdInput!) {
        updateProductByPrId(input: $input) {
          clientMutationId
          product {
            prId
            prJsonb
            prUpdatedate
            prCreateddate
          }
        }
      }`,
      "variables":{
        "input":{
          "clientMutationId": pr_id,
          "prId": pr_id,
          "productPatch": {
            "prJsonb": pr_jsonb
          }
        }
      }
    }).then((response) => {
        console.log(response);
         this.getProducts();
      }, (response) => {
        // error callback
         console.log(response);        
      });
    }  
  }
}

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  #pr_name {
    margin-left: 16px;
  }
  
  #add_product {
    margin-top: 8px;
  }
</style>