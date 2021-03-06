describe("Marker", function () {
	var map,
		spy,
		div,
		icon1,
		icon2;

	beforeEach(function () {
		div = document.createElement('div');
		div.style.height = '100px';
		document.body.appendChild(div);

		map = L.map(div).setView([0, 0], 0);
		icon1 = new L.Icon.Default();
		icon2 = new L.Icon.Default({
			iconUrl: icon1._getIconUrl('icon') + '?2',
			shadowUrl: icon1._getIconUrl('shadow') + '?2'
		});
	});

	afterEach(function () {
		document.body.removeChild(div);
	});

	describe("#setIcon", function () {
		it("changes the icon to another image", function () {
			var marker = new L.Marker([0, 0], {icon: icon1});
			map.addLayer(marker);

			var beforeIcon = marker._icon;
			marker.setIcon(icon2);
			var afterIcon = marker._icon;

			expect(beforeIcon).to.be(afterIcon);
			expect(afterIcon.src.replace(/\.\.\//g, '')).to.be(icon2._getIconUrl('icon').replace(/\.\.\//g, ''));
		});

		it("preserves draggability", function () {
			var marker = new L.Marker([0, 0], {icon: icon1});
			map.addLayer(marker);

			marker.dragging.disable();
			marker.setIcon(icon2);

			expect(marker.dragging.enabled()).to.be(false);

			marker.dragging.enable();

			marker.setIcon(icon1);

			expect(marker.dragging.enabled()).to.be(true);

			map.removeLayer(marker);
			map.addLayer(marker);

			expect(marker.dragging.enabled()).to.be(true);

			map.removeLayer(marker);
			// Dragging is still enabled, we should be able to disable it,
			// even if marker is off the map.
			marker.dragging.disable();
			map.addLayer(marker);
		});

		it("changes the icon to another DivIcon", function () {
			var marker = new L.Marker([0, 0], {icon: new L.DivIcon({html: 'Inner1Text'})});
			map.addLayer(marker);

			var beforeIcon = marker._icon;
			marker.setIcon(new L.DivIcon({html: 'Inner2Text'}));
			var afterIcon = marker._icon;

			expect(beforeIcon).to.be(afterIcon);
			expect(afterIcon.innerHTML).to.contain('Inner2Text');
		});

		it("removes text when changing to a blank DivIcon", function () {
			var marker = new L.Marker([0, 0], {icon: new L.DivIcon({html: 'Inner1Text'})});
			map.addLayer(marker);

			marker.setIcon(new L.DivIcon());
			var afterIcon = marker._icon;

			expect(marker._icon.innerHTML).to.not.contain('Inner1Text');
		});

		it("changes a DivIcon to an image", function () {
			var marker = new L.Marker([0, 0], {icon: new L.DivIcon({html: 'Inner1Text'})});
			map.addLayer(marker);
			var oldIcon = marker._icon;

			marker.setIcon(icon1);

			expect(oldIcon).to.not.be(marker._icon);
			expect(oldIcon.parentNode).to.be(null);

			if (L.Browser.retina) {
				expect(marker._icon.src).to.contain('marker-icon-2x.png');
			} else {
				expect(marker._icon.src).to.contain('marker-icon.png');
			}
			expect(marker._icon.parentNode).to.be(map._panes.markerPane);
		});

		it("changes an image to a DivIcon", function () {
			var marker = new L.Marker([0, 0], {icon: icon1});
			map.addLayer(marker);
			var oldIcon = marker._icon;

			marker.setIcon(new L.DivIcon({html: 'Inner1Text'}));

			expect(oldIcon).to.not.be(marker._icon);
			expect(oldIcon.parentNode).to.be(null);

			expect(marker._icon.innerHTML).to.contain('Inner1Text');
			expect(marker._icon.parentNode).to.be(map._panes.markerPane);
		});

		it("reuses the icon/shadow when changing icon", function () {
			var marker = new L.Marker([0, 0], {icon: icon1});
			map.addLayer(marker);
			var oldIcon = marker._icon;
			var oldShadow = marker._shadow;

			marker.setIcon(icon2);

			expect(oldIcon).to.be(marker._icon);
			expect(oldShadow).to.be(marker._shadow);

			expect(marker._icon.parentNode).to.be(map._panes.markerPane);
			expect(marker._shadow.parentNode).to.be(map._panes.shadowPane);
		});
	});

	describe("#setLatLng", function () {
		it("fires a move event", function () {

			var marker = new L.Marker([0, 0], {icon: icon1});
			map.addLayer(marker);

			var beforeLatLng = marker._latlng;
			var afterLatLng = new L.LatLng(1, 2);

			var eventArgs = null;
			marker.on('move', function (e) {
				eventArgs = e;
			});

			marker.setLatLng(afterLatLng);

			expect(eventArgs).to.not.be(null);
			expect(eventArgs.oldLatLng).to.be(beforeLatLng);
			expect(eventArgs.latlng).to.be(afterLatLng);
			expect(marker.getLatLng()).to.be(afterLatLng);
		});
	});

	describe('events', function () {
		it('fires click event when clicked', function () {
			var spy = sinon.spy();

			var marker = L.marker([0, 0]).addTo(map);

			marker.on('click', spy);
			happen.click(marker._icon);

			expect(spy.called).to.be.ok();
		});
	});
});
