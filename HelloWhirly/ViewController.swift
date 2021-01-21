//
//  ViewController.swift
//
//  Created by Greg Buehler on 1/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    let DoGlobe = false
    
    var theViewC: MaplyBaseViewController?
    var globeViewC: WhirlyGlobeViewController?
    var mapViewC: MaplyViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("creating view controller(s)")
        // Start with either globe or map
        if DoGlobe {
            print("starting as globe")
            let globeViewC = WhirlyGlobeViewController()
            theViewC = globeViewC
        } else {
            print("starting as slippy")
            let mapViewC = MaplyViewController()
            theViewC = mapViewC
        }

        // Wire this into the view hierarchy
        print("wiring up view controllers")
        self.view.addSubview(theViewC!.view)
        theViewC!.view.frame = self.view.bounds
        addChild(theViewC!)
        
        // we want a black background for a globe, a white background for a map.
        theViewC!.clearColor = (globeViewC != nil) ? UIColor.green : UIColor.purple

        // and 30 frames per second
        theViewC!.frameInterval = 2

        // Set up an MBTiles file and read the header
        guard let mbTilesFetcher = MaplyMBTileFetcher(mbTiles: "geography-class_medres")
        else {
            print("Can't load mbtiles?!")
            return
        }

        print("setting up sample params")
        // Sampling parameters define how we break down the globe
        let sampleParams = MaplySamplingParams()
        sampleParams.coordSys = mbTilesFetcher.coordSys()
        sampleParams.coverPoles = true
        sampleParams.edgeMatching = true
        sampleParams.minZoom = mbTilesFetcher.minZoom()
        sampleParams.maxZoom = mbTilesFetcher.maxZoom()
        sampleParams.singleLevel = true

        // The Image Loader does the actual work
        print("setting up image loader")
        guard let imageLoader = MaplyQuadImageLoader(params: sampleParams,
            tileInfo: mbTilesFetcher.tileInfo(),
            viewC: theViewC!)
        else {
            print("failed to configure image loader")
            return
        }
        imageLoader.setTileFetcher(mbTilesFetcher)
        imageLoader.baseDrawPriority = kMaplyImageLayerDrawPriorityDefault

        print("starting up")
        // start up over Madrid, center of the old-world
        if let globeViewC = globeViewC {
            globeViewC.height = 0.8
            globeViewC.animate(toPosition: MaplyCoordinateMakeWithDegrees(-3.6704, 40.5023),
            time: 1.0)
        }
        else if let mapViewC = mapViewC {
            mapViewC.height = 1.0
            mapViewC.animate(toPosition: MaplyCoordinateMakeWithDegrees(-3.6704, 40.5023),
            time: 1.0)
        }
    }


}

