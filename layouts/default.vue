<template>
  <div class="card">
    <Menubar :model="items">
      <template #item="{ item, props }">
        <NuxtLink v-slot="{ href, navigate, isActive }" :to="item.to" custom>
          <a
            v-ripple
            :href="href"
            v-bind="props.action"
            @click="navigate"
            :class="[isActive && 'router-link-active']"
          >
            <span :class="item.icon" />
            <span class="ml-2">{{ item.label }}</span>
          </a>
        </NuxtLink>
      </template>
    </Menubar>
  </div>

  <div>
    <slot />
  </div>

  <footer></footer>
</template>

<script setup>
import { ref } from "vue";

const items = ref([
  {
    label: "Home",
    to: "/",
  },
  {
    label: "Products",
    to: "/products",
  },
]);
</script>

<style>
.router-link-active {
  background: red;
}
</style>
