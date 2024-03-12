<template>
  <div class="py-3 flex sidecart">
    <Sidebar
      v-model:visible="visibleRight"
      header="Your Cart"
      position="right"
      class="sidebarwidth"
    >
      <div>
        <webkurv />
        <div class="flex flex-col items-center">
          <NuxtLink
            class="btn mt-8 mb-2 w-40 text-center"
            to="/webshopcheckout"
          >
            Check Out
          </NuxtLink>
          <Button class="btn w-40" @click="visibleRight = false"
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
import { ref, computed, watchEffect } from "vue";

const cart = useState("shoppingcart", () => []);

const visibleRight = useState("showcart", () => false);
</script>

<style>
button {
  transition: 1s;
}
button:hover {
  background-color: grey;
}
.sidebarwidth {
  width: 600px;
}
.sidecart .p-sidebar {
  width: 600px;
}
</style>
