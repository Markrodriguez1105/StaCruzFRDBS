
/**
 * router/index.ts
 *
 * Automatic routes for `./src/pages/*.vue`
 */

// Composables
import { createRouter, createWebHistory } from 'vue-router'
import Data from '@/pages/Data.vue';
import Login from '@/components/Login.vue';
import Form from '@/pages/Form.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/Data',
      name: 'Data',
      component: Data,
    },
    {
      path: '/Login',
      name: 'Login',
      component: Login,
    },
    {
      path: '/Form',
      name: 'Form',
      component: Form,
    },
  ]
})

export default router
