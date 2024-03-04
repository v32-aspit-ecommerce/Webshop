<template>
  <div class="back">
    <div class="indbetal">
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
    <div class="kurv">
      <div class="produkt">
        <img src="https://unsplash.it/100/100" alt="produktbillede" />
        <div>
          <h4>Produktnavn</h4>
          <div>
            <p>Farve</p>
            |
            <p>Størrelse</p>
          </div>
        </div>
        <h4>Pris</h4>
      </div>
      <div class="card flex justify-content-center kupon">
        <InputText type="text" v-model="value" />
        <Button label="Submit" />
      </div>
      <div>
        <p>Subtotal</p>
        <p>Shipping</p>
        <p>Total</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import Checkbox from "primevue/checkbox";
import { ref } from "vue";
import Button from "primevue/button";

const checked = ref(false);
const selectedCountries = ref();
const value = ref(null);
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
.centering {
  width: 80%;
  margin: auto;
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
.p-inputnumber {
  margin-left: 10px;
  height: 30px;
  width: 100%;
}
.flex {
  align-items: center;
}
.produkt {
  display: flex;
  height: 200px;
}
.produkt img {
  margin: 10px;
  border-radius: 10px;
}
.produkt div {
  display: flex;
  align-content: space-between;
}
.produkt div div {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
}
.kupon {
  height: 50px;
}
</style>
