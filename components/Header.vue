<template>
  <div class="card card1">
    <div class="search iconcard">
      <i class="searchicon pi pi-search">
        <input class="searchinput" type="text" />
      </i>
    </div>
    <div class="logo">
      <NuxtLink to="/">
        <img src="http://placehold.it/250x60?text=hello+world" alt="" />
      </NuxtLink>
    </div>

    <div class="flex">
      <i class="shoppingbag pi pi-shopping-bag"></i>
      <div class="login iconcard">
        <i class="userlogo pi pi-user"></i>

        <p>Login</p>
      </div>
    </div>
  </div>
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
    <a href="login.vue">
      <div class="login">
        <img src="https://unsplash.it/40/40" alt="Profil" />
        <p>Login</p>
      </div>
    </a>
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
.userlogo {
  font-size: 1.5rem;
  border-radius: 999px;
}

.router-link-active {
  color: hsl(164, 82%, 39%);
}

.card {
  display: flex;
  justify-content: space-evenly;
  align-items: center;
}

.card1 {
  display: none;
  justify-content: space-between;
  margin-top: 1.3rem;
}

.searchicon {
  margin-left: 5px;
}

.searchinput {
  width: 87%;
}

.shoppingbag {
  margin-top: 1.3rem;
  margin-right: 2rem;
  font-size: 1.7rem;
}

.search {
  height: 2vw;
  width: 15vw;
  margin-top: 10px;
  margin-left: 50px;
}

.login {
  height: 4vw;
  width: 10vw;
  margin-right: 50px;
}

.iconcard {
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  border-color: black;
  border: 2px;
  border-style: solid;
  border-radius: 10px;
  margin-top: 10px;
}

@media screen and (min-width: 962px) {
  .card1 {
    display: flex;
  }

  margin-right: 50px;
  border: 2px;
  border-radius: 10px;
  border-color: black;
  border-style: solid;
  width: 100px;
}
.login img {
  border-radius: 25px;
}
</style>
