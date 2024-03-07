<template>
  <div class="back">
    <div class="indbetal">
      <div class="flex justify-content-center">
        <Breadcrumb :home="home" :model="items" />
      </div>
      <div class="centering">
        <h2>Kontakt information</h2>
        <div class="flex flex-column gap-2">
          <InputText
            id="email"
            v-model="value"
            aria-describedby="email-help"
            placeholder="Email"
          />
        </div>
        <div class="check">
          <Checkbox v-model="checked" :binary="true" name="ad" class="check" />
          <p>Tilmeld mig opdateringer angående nye tilbud</p>
        </div>

        <h2>Shipping</h2>
        <MultiSelect
          v-model="selectedCountries"
          :options="countries"
          optionLabel="name"
          placeholder="Select Countries"
          display="chip"
          class="w-full md:w-20rem"
        >
          <template #option="slotProps">
            <div class="flex align-items-center">
              <img
                :alt="slotProps.option.name"
                src="https://primefaces.org/cdn/primevue/images/flag/flag_placeholder.png"
                :class="`flag flag-${slotProps.option.code.toLowerCase()} mr-2`"
                style="width: 18px"
              />
              <div>{{ slotProps.option.name }}</div>
            </div>
          </template>
          <template #footer>
            <div class="py-2 px-3">
              <b>{{ selectedCountries ? selectedCountries.length : 0 }}</b>
              item{{
                (selectedCountries ? selectedCountries.length : 0) > 1
                  ? "s"
                  : ""
              }}
              selected.
            </div>
          </template>
        </MultiSelect>
        <div>
          <div class="flex flex-column gap-2">
            <InputText
              id="fornavn"
              v-model="value"
              aria-describedby="navn-help"
              placeholder="Fornavn"
            />
            <InputText
              id="efternavn"
              v-model="value"
              aria-describedby="efternavn-help"
              placeholder="Efternavn"
            />
          </div>
        </div>
        <div class="flex flex-column gap-2">
          <InputText
            id="adresse"
            v-model="value"
            aria-describedby="adresse-help"
            placeholder="Adresse"
          />
        </div>
        <br />
        <div class="flex flex-column gap-2">
          <InputText
            id="anummer"
            v-model="value"
            aria-describedby="anummer-help"
            placeholder="Adresse Nr."
          />
        </div>
        <div>
          <div class="flex flex-column gap-2">
            <InputNumber
              id="postnummer"
              v-model="value"
              aria-describedby="pnummer-help"
              placeholder="Postnummer"
            />
            <InputText
              id="by"
              v-model="value"
              aria-describedby="by-help"
              placeholder="By"
            />
          </div>
        </div>
        <div class="check">
          <Checkbox
            v-model="checked"
            :binary="true"
            name="kortinfo"
            class="check"
          />
          <p>Gem mine kortinformationer</p>
        </div>
      </div>
    </div>
    <div>
      <webkurv />
    </div>
  </div>
</template>

<script setup>
import Checkbox from "primevue/checkbox";
import { ref } from "vue";

import Breadcrumb from "primevue/breadcrumb";

const checked = ref(false);
const selectedCountries = ref();
const countries = ref([
  { name: "Australia", code: "AU" },
  { name: "Brazil", code: "BR" },
  { name: "China", code: "CN" },
  { name: "Egypt", code: "EG" },
  { name: "France", code: "FR" },
  { name: "Germany", code: "DE" },
  { name: "India", code: "IN" },
  { name: "Japan", code: "JP" },
  { name: "Spain", code: "ES" },
  { name: "United States", code: "US" },
]);
const home = ref({
  icon: "pi pi-home",
});
const items = ref([{ label: "Webshop" }]);
</script>

<style scoped>
.back {
  display: flex;
  flex-direction: row;
}
.indbetal {
  background-color: rgb(242, 242, 242);
  width: 50vw;
  padding-bottom: 50px;
}
.indbetal div:nth-child(1) {
  height: 100px;
}
.indbetal div nav {
  background-color: transparent;
}

.centering {
  width: 80%;
  margin: 0 auto;
}
.centering:nth-of-type(1) {
  margin-top: 100px;
}
.kurv {
  width: 50vw;
  background-color: rgb(250, 250, 250);
  height: auto;
  display: flex;
  flex-direction: column;
}
.check {
  display: flex;
  justify-content: flex-start;
  margin-left: 5px;
}
.check p {
  margin-left: 10px;
}
select,
h2 {
  margin-left: 10px;
  margin-bottom: 5px;
  margin-top: 5px;
}
input {
  border: solid;
  border-color: rgb(218, 218, 218);
  width: 45%;
  margin: 10px;
}
.p-inputtext {
  width: 100%;
}
.centering div div .p-inputnumber {
  margin-left: 10px;
  height: 30px;
  width: 100%;
}
.flex {
  align-items: center;
}
.produkt {
  display: flex;
}
.produkt img {
  margin: 10px;
  border-radius: 10px;
}
.produkt div {
  display: flex;
  justify-content: space-between;
}
.produktinfo {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}
.produktinfo .p-inputnumber-input {
  width: 20px;
}
.produkt div div {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
}
.kupon {
  height: 50px;
  background-color: rgb(250, 250, 250);
}
.produktinfo button {
  width: 20px;
}
.apply {
  width: 10%;
  background-color: rgb(203, 186, 211);
}
.stats {
  display: flex;
  justify-content: space-between;
}
.delete {
  flex-direction: column;
  align-items: center;
  margin-bottom: 3px;
}
</style>
