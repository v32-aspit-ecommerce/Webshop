<template>
  <div class="py-3 flex">
    <Sidebar
      v-model:visible="visibleRight"
      header="Your Cart"
      position="right"
      class="w-96"
    >
      <div>
        <webkurv />
        <div class="flex flex-col">
          <NuxtLink class="btn mb-2" to="/webshopcheckout">
            Check Out
          </NuxtLink>
          <Button class="btn" @click="visibleRight = false"
            >Continue Shopping</Button
          >
        </div>
      </div>
    </Sidebar>
    <Button
      icon="pi pi-shopping-bag"
      class="mr-4"
      @click="visibleRight = true"
    />
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
