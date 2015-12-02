import Ember from 'ember';

export function initialize() {
  Ember.$.ajaxPrefilter(function(options, originalOptions, jqXHR) {
    let userTokenStorageKey = 'torii-user-token';
    var token = localStorage.getItem(userTokenStorageKey);

    if (token){
      jqXHR.setRequestHeader('X-User-Auth-Token', token);
    }
  });
}

export default {
  name: 'ajax-prefilter',
  initialize: initialize
};
