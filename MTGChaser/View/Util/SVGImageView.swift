//
//  SVGImageView.swift
//  MTGChaser
//
//  Created by Bruna on 2025-04-24.
//

import SwiftUI
import SVGKit

struct SVGImageView: UIViewRepresentable {
    let url: URL
    var size: CGSize
    
    class Coordinator {
        var imageView: SVGKFastImageView?
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> UIView {
        
        guard let imageView = SVGKFastImageView(svgkImage: SVGKImage()) else { return UIView() }
        
        context.coordinator.imageView = imageView
        
        loadSVGAsync(into: imageView)
        return imageView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        
        guard let view = uiView as? SVGKFastImageView else { return }
        
        view.contentMode = .scaleAspectFit
        view.image.size = size
    }
    
    private func loadSVGAsync(into imageView: SVGKFastImageView) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: url),
                  let svgImage = SVGKImage(data: data) else {
                print("⚠️ Failed to load or parse SVG from: \(url)")
                return
            }
            
            svgImage.size = size
            
            Task { @MainActor in
                imageView.image = svgImage
            }
        }
    }
}
