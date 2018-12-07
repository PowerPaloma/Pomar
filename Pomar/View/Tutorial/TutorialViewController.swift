//
//  TutorialViewController.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 26/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var viewBackground: UIView!

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var slides:[SlideTutorial] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        slides = createSlides()
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        let layerBackground = viewBackground.layer
        layerBackground.masksToBounds = false
        layerBackground.cornerRadius = 8
        layerBackground.shadowOffset = CGSize(width: 0, height: 3)
        layerBackground.shadowOpacity = 0.5
       // view.bringSubviewToFront(pageControl)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
         setupSlideScrollView(slides: slides)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func createSlides() -> [SlideTutorial]{
        let slide1: SlideTutorial = Bundle.main.loadNibNamed("SlideTutorial", owner: self, options: nil)?.first as! SlideTutorial
        
        slide1.image1.image = UIImage(named: "appleRed")
        slide1.text1.text = "This mace should be given to the people present in the group"
        slide1.image2.image = UIImage(named: "appleOrange")
        slide1.text2.text = "This mace should be given to the people who stood out in the group"
        
        
        let finalSlide: FinalTutorial = Bundle.main.loadNibNamed("FinalTutorial", owner: self, options: nil)?.first as! FinalTutorial
        
        finalSlide.imageFinal.image = UIImage(named: "shapeSword")
        finalSlide.textFinal.text = "Take on the challenges to complete your quests, they unlock bad badges for you to collect and help you gain XP to level up"
        finalSlide.delegate = self
        
        
        return [slide1,finalSlide]
    }
    
    func setupSlideScrollView(slides : [SlideTutorial]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: viewBackground.frame.width, height: viewBackground.frame.height)
        scrollView.contentSize = CGSize(width: viewBackground.frame.width * CGFloat(slides.count), height: viewBackground.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count{
            slides[i].frame = CGRect(x: viewBackground.frame.width * CGFloat(i), y: 0, width: viewBackground.frame.width, height: viewBackground.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
}

extension TutorialViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/viewBackground.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
//        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
//        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
//
//        // vertical
//        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
//        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
//
//        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
//        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
        
        /*
         * below code scales the imageview on paging the scrollview
         */
//        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
//        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
//
//            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
//            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
//
//        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
//            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
//            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
//
//        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
//            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
//            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
//
//        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
//            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
//            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
//        }
    }
}

extension TutorialViewController: FinalTutorialDelegate{
    func tapButtonInFinalTutorial() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {return}
        
        self.present(initialViewController, animated: true, completion: nil)
    }
}
