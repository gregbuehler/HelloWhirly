//
//  ViewController.swift
//
//  Created by Greg Buehler on 1/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var theViewC: MaplyBaseViewController? = nil
    private var mapViewC: MaplyViewController? = nil
    private var imageLoader: MaplyQuadImageLoader? = nil
    private var tileInfo: MaplyRemoteTileFetcher? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("creating view controller")
        let mapViewC = MaplyViewController()
        theViewC = mapViewC

        // Wire this into the view hierarchy
        print("wiring up view controllers")
        self.view.addSubview(theViewC!.view)
        theViewC!.view.frame = self.view.bounds
        addChild(theViewC!)
        
        // set the background
        theViewC!.clearColor = UIColor.green

        // and 30 frames per second
        theViewC!.frameInterval = 2

        // Where do we get the tiles and were do we cache them?
        let cacheDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        let thisCacheDir = "\(cacheDir)/stamentiles/"
        let maxZoom = Int32(16)
        let tileInfo = MaplyRemoteTileInfoNew(baseURL: "https://stamen-tiles-a.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.png",
                                              minZoom: Int32(0),
                                              maxZoom: Int32(maxZoom))
        tileInfo.cacheDir = thisCacheDir

        // Sampling parameters define how we break down the globe
        let sampleParams = MaplySamplingParams()
        sampleParams.coordSys = MaplySphericalMercator(webStandard: ())
        sampleParams.coverPoles = true
        sampleParams.edgeMatching = true
        sampleParams.minZoom = tileInfo.minZoom
        sampleParams.maxZoom = tileInfo.maxZoom
        sampleParams.singleLevel = true

        // The Image Loader does the actual work
        let imageLoader = MaplyQuadImageLoader(params: sampleParams, tileInfo: tileInfo, viewC: theViewC!)
        imageLoader!.baseDrawPriority = kMaplyImageLayerDrawPriorityDefault
          
        
        print("starting up")
        mapViewC.height = 1.0
        mapViewC.animate(toPosition: MaplyCoordinateMakeWithDegrees(-3.6704, 40.5023), time: 1.0)
    }


}

