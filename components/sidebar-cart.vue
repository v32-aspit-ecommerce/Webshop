<template>
  <div class="card flex justify-center">
    <Sidebar v-model:visible="visibleRight" header="Cart" position="right">
      <p>Data inc..</p>
    </Sidebar>
    <Button icon="pi pi-shopping-bag" @click="visibleRight = true" />
  </div>
</template>

<script setup>
import "primeicons/primeicons.css";
import { ref } from "vue";

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
