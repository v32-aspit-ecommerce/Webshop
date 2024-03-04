<template>
  <div class="flex hidden md:flex justify-between bg-white items-center pt-6">
    <div class="search ml-12 h-6 mt-2 iconcard">
      <i class="ml-2 pi pi-search">
        <input class="searchinput" type="text" />
      </i>
    </div>

    <sidebar-cart />

    <div class="logo">
      <NuxtLink to="/">
        <img
          class="w-24 md:w-52"
          src="http://placehold.it/120x40?text=hello+world"
          alt=""
        />
      </NuxtLink>
    </div>

    <div class="mt-2 flex">
      <NuxtLink to="/webshopcheckout">
        <i class="shoppingbag mr-6 pi pi-shopping-bag"></i>
      </NuxtLink>

      <div class="login mr-12 iconcard">
        <i class="rounded-full text-2xl pi pi-user"></i>
        <p>Login</p>
      </div>
    </div>
  </div>

  <div class="bg-white flex justify-between md:justify-evenly items-center">
    <div class="flex md:hidden items-center">
      <div class="mr-4 search ml-4 h-6 mt-2 iconcard">
        <i class="ml-2 pi pi-search">
          <input class="searchinput" type="text" />
        </i>
      </div>
      <div class="mr-6 logo">
        <NuxtLink to="/">
          <img
            class="w-24 md:w-52"
            src="http://placehold.it/120x40?text=hello+world"
            alt=""
          />
        </NuxtLink>
      </div>

      <div class="mt-2 flex">
        <NuxtLink to="/webshopcheckout">
          <i class="mr-2 shoppingbag pi pi-shopping-bag"></i>
        </NuxtLink>

        <div class="w-10 iconcard">
          <i class="rounded-full text-xl pi pi-user"></i>
        </div>
      </div>
    </div>
    <Menubar class="test" :model="items">
      <template class="" #item="{ item, props }">
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
</template>
<script setup>
import { ref } from "vue";

const items = ref([
  {
    label: "Home",
    to: "/",
  },
  {
    label: "Collection",
    to: "/collections/",
  },
  {
    label: "Products",
    to: "/products?item",
  },
  {
    label: "Gift Boxes",
    to: "/GiftBoxes",
  },
  {
    label: "Gift Card",
    to: "/GiftCard",
  },
  {
    label: "About Us",
    to: "/AboutUs",
  },
  {
    label: "Contact",
    to: "/Contact",
  },
  {
    label: "Blog",
    to: "/blog",
  },
]);
</script>

<style scoped>
.iconcard {
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  border-color: black;
  border: 2px;
  border-style: solid;
  border-radius: 10px;
}

.shoppingbag {
  margin-top: 1.3rem;

  font-size: 1.7rem;
}

.router-link-active {
  color: hsl(164, 82%, 39%);
}
.searchinput {
  width: 84%;
}
.search {
  width: 25vw;
}
.login {
  width: 10vw;
}
.test {
  width: 22vw;
  display: flex;
  justify-content: end;
}

@media screen and (min-width: 962px) {
  .test {
    width: auto;
  }
}
</style>
