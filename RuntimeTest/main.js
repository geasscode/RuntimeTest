//main.js
defineClass('MineViewController:UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>', {
	
			collectionView_numberOfItemsInSection: function(collectionView, section) {
        return 6;
    }
});