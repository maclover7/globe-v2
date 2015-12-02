import DS from 'ember-data';

let userTokenStorageKey = 'torii-user-token';

export default DS.RESTAdapter.extend({
  headers: {
    "user_auth_token": localStorage.getItem(userTokenStorageKey)
  }
});
