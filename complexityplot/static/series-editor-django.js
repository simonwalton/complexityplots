// This is a module for cloud persistance in mongolab - https://mongolab.com
angular.module('series-editor-django', ['ngResource']).
    factory('Series', function($resource) {
		var Series = $resource(url_prefix+'/series-edit/:id/', {},
		 {
			query: { method: 'GET', cache:false, isArray:true, headers:
				{'X-CSRFToken' : csrftoken,
				'Pragma': 'no-cache',
				'Cache-Control': 'no-cache, no-store'
				}
			},
			update: { method: 'POST', cache:false, headers:
				{'X-CSRFToken' : csrftoken,
				'Pragma': 'no-cache',
				'Cache-Control': 'no-cache, no-store',
				'Content-type': 'application/www-form-urlencoded'
				}
			},
			remove: { method: 'DELETE', cache:false, headers:
				{'X-CSRFToken' : csrftoken,
				'Pragma': 'no-cache',
				'Cache-Control': 'no-cache, no-store'
				}
			},
		 }
		);

		Series.prototype.update = function(cb) {
			return Series.update({id: this._id},
				angular.extend({}, this, {_id:undefined}), cb);
			};

		Series.prototype.create = function(cb) {
			return Series.update({id: this._id},
				angular.extend({}, this, {_id:undefined}), cb);
			};

		Series.prototype.destroy = function(cb) {
			return Series.remove({id: this._id},
				angular.extend({}, this, {_id:undefined}), cb);
		};

		return Series;
	});
