// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'
import VueMaterial from 'vue-material'
import VueMaterialCSS from '../node_modules/vue-material/dist/vue-material.css'
import './styles.scss';

import Hello from './components/Hello'
import Toolbar from './components/Toolbar'
import Products from './components/Products'

Vue.use(VueRouter)
Vue.use(VueResource)
Vue.use(VueMaterial)

Vue.material.registerTheme('default', {
  primary: 'blue',
  accent: 'red'
})

Vue.component('toolbar', Toolbar)

// 1. Define route components.
// These can be imported from other files
const NotFound = { template: '<p>Page not found</p>' }

// 2. Define some routes
// Each route should map to a component. The "component" can
// either be an actual component constructor created via
// Vue.extend(), or just a component options object.
// We'll talk about nested routes later.
const routes = [
  { path: '/hello', component: Hello },
  { path: '/products', component: Products },
  { path: '*', component: NotFound }
]

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
const router = new VueRouter({
  routes // short for routes: routes
})

// 4. Create and mount the root instance.
// Make sure to inject the router with the router option to make the
// whole app router-aware.
const app = new Vue({
  router
}).$mount('#app')

