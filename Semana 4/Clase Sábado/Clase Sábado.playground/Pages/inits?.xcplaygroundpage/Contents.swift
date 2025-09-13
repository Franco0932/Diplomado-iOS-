import UIKit

class MediaItem {
    let id: UUID
    let tittle: tittle
    
    init() {
        self.id = UUID ()
        self.tittle = tittle
    }
    func display() -> String {
        ""
    }
}

let mediaItem = MediaItem(tittle: "Media Item")

class video: MediaItem{
    let duaration: TimeInterval
    
    init (duaration: TimeInterval) {
        self.duaration = duaration
        super.init(tittle: tittle)
    }
}

let video = video(Duration: 0.2)










































