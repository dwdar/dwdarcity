<template>
  <div class="footer">
    <ul>
      <li v-for="(nav,key) in footer_list" :key="key">
        <span v-if="nav.is_site"><a :href="nav.link">{{nav.title}}</a></span>
        <span v-else><router-link :to="nav.link">{{ nav.title }}</router-link></span>
      </li>
    </ul>
    <p>زەرتتەپ جاساعان «تالپىنىس» توبى | جەتەكشى ونەرحان قىزىر ۇلى | باسپا ۇقىعى قورعاۋلى </p>
    <p>Copyright © dwdarcity.com版权所有 | 京ICP备17072161号-1</p>
  </div>
</template>

<script>
export default {
  name: "Footer",
  data() {
    return {
      footer_list: []
    }
  },
  created() {
    this.get_footer()
  },
  methods: {
    get_footer() {
      this.$axios.get(`${this.$settings.HOST}/nav/footer/`, {}).then(response => {
        this.footer_list = response.data
      }).catch(error => {
        console.log(error.response)
      })
    }
  }
}
</script>

<style scoped>
.footer {
  width: 100%;
  height: 128px;
  background: #25292e;
  color: #fff;
}

.footer ul {
  margin: 0 auto 16px;
  padding-top: 38px;
  width: 810px;
}

.footer ul li {
  float: right;
  width: 112px;
  margin: 0 10px;
  text-align: center;
  font-size: 14px;
}

.footer ul::after {
  content: "";
  display: block;
  clear: both;
}

.footer p {
  text-align: center;
  font-size: 12px;
}
.footer a {
  color:#ffffff;
}

</style>
