<template>
  <div class="card flex justify-center">
    <Sidebar
      v-model:visible="visibleRight"
      header="Your Cart"
      position="right"
      class="w-2/6"
    >
      <p>dette er en test</p>
      <div>
        <div v-for="item in cart" :key="item.id">
          <h2>{{ item.title }}</h2>
          <p>Price - ${{ item.price }}</p>
        </div>
      </div>
    </Sidebar>
    <Button icon="pi pi-shopping-bag" @click="visibleRight = true" />
  </div>
</template>

<script setup>
const cart = useState("shoppingcart");

const visibleRight = ref(false);
</script>

<style scoped>
button {
  transition: 1s;
}
button:hover {
  background-color: grey;
}
</style>
