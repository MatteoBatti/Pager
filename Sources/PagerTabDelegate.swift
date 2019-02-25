//
//  PagerTab
//
//  Created by Matteo Battistini on 25/02/2019.
//

import Foundation


public protocol PagerTabDelegate: class {
    func pageDidAppear(_ index: Int, page: PagerTabPage)
}
