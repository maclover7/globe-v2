import Ember from 'ember';

export default Ember.Route.extend({
  beforeModel() {
    return this.get('session').fetch('google-oauth2').then(() => {
      // no-op, we are logged in
    }).catch(() => {
      // no-op, it is ok if we are not logged in
    });
  },

  actions: {
    accessDenied() {
      this.transitionTo('application');
    },

    signIn() {
      let { controller } = this;
      let session = this.get('session');

      controller.set('error', null);

      session.open('google-oauth2').then(() => {
        // no-op, we are signed in
        if (session.attemptedTransition) {
          session.attemptedTransition.retry();
          session.attemptedTransition = null;
        }
      }).catch(err => {
        Ember.run(controller, 'set', 'error', err);
        alert('Authentication failed!');
      });
    },

    signOut() {
      this.get('session').close('google-oauth2');
    }
  }
});
