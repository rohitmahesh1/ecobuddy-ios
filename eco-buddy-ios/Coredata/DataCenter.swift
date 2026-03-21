//
//  DataCenter.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 10/10/23.
//

import Foundation
import CoreData

struct ModuleData {
    struct ModuleLocal {
        let id: String
        let title: String
        let categoryIds: [String]

        var displayOrder: Int16 {
            Int16(id) ?? 0
        }
    }
    
    static let modules: [ModuleLocal] = [
        ModuleLocal(id: "1", title: "Home", categoryIds: ["1", "2", "3"])
    ]
}

struct ChallengeCategoryData {
    struct Category {
        let id: String
        let categoryTitle: String
        let categoryDescription: String
        let challengeIds: [String]

        var displayOrder: Int16 {
            Int16(id) ?? 0
        }
    }
    
    static let categories: [Category] = [
        Category(id: "1", categoryTitle: "Clean Air: Challenge Yourself to Breathe Easy", categoryDescription: "Take on fun challenges that promote clean air and healthy living", challengeIds: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]),
        Category(id: "2", categoryTitle: "Healthy Living: Pledge for a healthier you", categoryDescription: "Choose eco-friendly actions, one pledge at a time", challengeIds: ["11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22"]),
        Category(id: "3", categoryTitle: "Awareness - Your guide to Environmental Insights", categoryDescription: "Explore topics like pollution and asthma. Bridge the gap from knowledge to action", challengeIds: ["23", "24", "25", "26", "27", "28", "29", "30", "31", "32"])
    ]
}
struct ChallengesData {
    
    struct ChallengeLocal {
        let id: String
        let challengeTitle: String
        let challengeDescription: String
        var challengeImage: String? = nil
        var subChallengeIds: [String]? = nil
        var videoURL: String? = nil
        var isCompleted = false

        var displayOrder: Int16 {
            Int16(id) ?? 0
        }
    }
    
    static let challenges: [ChallengeLocal] = [
        
        ChallengeLocal(
            id: "1",
            challengeTitle: "Join the Fresh Air Wellness Challenge:",
            challengeDescription: "Step outside, get active, and breathe in that clean air! Take just 30 minutes today to do something you genuinely enjoy and boost your well-being – run, bike, stroll – you choose! Snap a selfie while you're at it and share your outdoor energy on social media. Don't forget to tag it with #FreshAirWellnessChallenge. Let's stay active and enjoy the cleaner air together!",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979800/Ecobuddy/Join_the_Fresh_Air_Wellness_Challenge-1_stxlbb.png",
            subChallengeIds: ["1", "2", "3", "4"]
        ),
        
        
        ChallengeLocal(
            id: "2",
            challengeTitle: "Clean Air Quest - No Tech Day:",
            challengeDescription: "Challenge yourself to unplug from screens this weekend and enjoy a tech-free day outdoors. Reconnect with nature and embrace the fresh air around you while discovering new interests to enrich your life. Share your tech-free adventures using #NoTechDay and encourage others to disconnect and breathe in fresh air.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979804/Ecobuddy/Clean_Air_Quest_-_No_Tech_Day-2_ouo8id.png",
            subChallengeIds: ["5", "6", "7", "8"]
        ),
        
        ChallengeLocal (
            id: "3",
            challengeTitle: "Air Quality Storytelling",
            challengeDescription: "Share a personal experience related to recent poor air quality in Michigan this summer, caused by events like wildfires. Elaborate on how this experience reinforces the significance of clean air. Share with #AirQualityStory to raise awareness about air pollution and its solutions.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696981002/Ecobuddy/Air_Quality_Storytelling-3_kbavux.png",
            subChallengeIds: ["9", "10", "11"]
        ),
        
        ChallengeLocal (
            id: "4",
            challengeTitle: "Green Commute Challenge",
            challengeDescription: "Let's reduce air pollution together by changing how we get around! For a week, choose eco-friendly transportation like biking, walking, or carpooling to school or work. Share your green commuting journey on social media using #GreenCommuteChallenge. Small changes, big impact!",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979805/Ecobuddy/Green_Commute_Challenge-4_kdkr0s.png",
            subChallengeIds: ["12", "13", "14", "15"]
        ),
        
        ChallengeLocal (
            id: "5",
            challengeTitle: "Breathe Easy with Indoor Plants:",
            challengeDescription: "Plants are nature's air purifiers! Get an easy-to-care-for indoor plant for better air quality in your home! Share pictures of your plant buddies with #BreatheWithIndoorPlant and show how you're improving indoor air quality.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979725/Ecobuddy/BreatheEasywithIndoorPlants-5_gvrgba.jpg",
            subChallengeIds: ["16", "17", "18"]
        ),
        
        ChallengeLocal (
            id: "6",
            challengeTitle: "Air Quality monitoring challenge",
            challengeDescription: "Become an air quality awareness expert! Check your Air Quality Index (AQI) daily and share your observations on social media with #AirQualityMI and raise awareness about the importance of clean air in Michigan",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979799/Ecobuddy/MI-AirQuality_Monitoring_Challenge_-6_bfmokl.png",
            subChallengeIds:  ["19", "20", "21"]
        ),
        
        ChallengeLocal (
            id: "7",
            challengeTitle: "Community Environmental Awareness:",
            challengeDescription: "Promote awareness for cleaner air in your community! Learn about pollution causes and possible solutions. Share your insights and ideas on social media using the tag #MIPollutionSolutions. Let's learn, discuss, and work together to make our communities healthier for all!",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979806/Ecobuddy/Community_Environmental_Awareness_-7_llzftz.png",
            subChallengeIds: ["22", "23", "24", "25"]
        ),
        
        ChallengeLocal(
            id: "8",
            challengeTitle: "Green It Up Challenge",
            challengeDescription: "Just one plant can make a difference! Your mission is to plant one seedling, shrub, or flower within the next month. Here's how to participate: Choose one plant of your choice. Plant it in your patio or backyard. Snap a photo of your plant and share it on social media with the hashtag #GreenItUpChallenge. Nominate a friend or family member to take on the challenge as well. Let's make our world greener and healthier, one plant at a time! Are you ready for the challenge? 🌱🌍",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979798/Ecobuddy/GreenItUpChallenge-8_ccqy4q.png",
            subChallengeIds: ["26", "27", "28", "29"]
        ),
        
        ChallengeLocal (
            id: "9",
            challengeTitle: "Air Quality Emoji Challenge",
            challengeDescription: "Use emojis to represent different aspects of clean air and share a short message on social media using only emojis. Let's communicate the importance of clean air for health in a fun way!",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979725/Ecobuddy/AirQualityEmojiChallenge-9_vxfxbq.png",
            subChallengeIds: ["30", "31", "32", "33"]
        ),
        
        ChallengeLocal(
            id: "10",
            challengeTitle: "Be a Changemaker Challenge",
            challengeDescription: """
    Create a social media post about an environmental issue you care about that gets people thinking. Every like and share is more than just a click – it's a way to build a community of change-makers. Are you ready to make a difference? Let's come together for a better future, one post at a time. Who's ready to be a Changemaker? Let the campaign begin!"
    
    Healthy Living in Pure Michigan
    Make a commitment to take actions that benefit your health and environment at the same time! Here's how to participate: Choose a healthy and eco-friendly action you pledge to do. Share your pledge on social media using #HealthyMILiving. Tag one of your friends to join in and make their pledges too! Together, let's create a healthier world, one pledge at a time! Can we count on you to take the pledge? 🌿🌎
    """,
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979726/Ecobuddy/Be_A_ChangeMakerChallenge-10_h1ot1z.png"
        ),
        
        ChallengeLocal(
            id: "11",
            challengeTitle: "Support Local Farmers",
            challengeDescription: "Buy locally grown and organic produce from Michigan farmers' markets. This reduces the carbon footprint associated with transporting food long distances and promotes healthier eating.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979800/Ecobuddy/SupportLocalFarmers-Pledge1_jtkdaq.png"
        ),
        
        ChallengeLocal(
            id: "12",
            challengeTitle: "Outdoor Activities",
            challengeDescription: "Explore Michigan's nature by hiking, biking, or kayaking in state parks and recreational areas. Enjoying the outdoors not only benefits your health but also supports conservation efforts and promotes eco-tourism n Michigan.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979803/Ecobuddy/OutdoorActivities-Pledge2_ekyq4q.png"
        ),
        
        ChallengeLocal(
            id: "13",
            challengeTitle: "Reduce Energy Consumption",
            challengeDescription: "Turn of lights and appliances when not in use to reduce energy consumption and decrease the environmental impact of energy production.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1695773225/Ecobuddy/CleanenvironmentPledge.png"
        ),
        
        ChallengeLocal(
            id: "14",
            challengeTitle: "Use Public Transportation",
            challengeDescription: "Whenever possible, use public transportation or carpool to reduce air pollution and traffic congestion in cities like Canton, Detroit, Ypsilanti, Ann Arbor and Grand Rapids.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979800/Ecobuddy/UsePublicTransportationPledge-4_a7n4ow.png"
        ),
        
        ChallengeLocal(
            id: "15",
            challengeTitle: "Native Plant Gardening",
            challengeDescription: "Grow native Michigan plants. They require less water, support local wildlife, and help preserve the Michigan’s natural ecosystem.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979804/Ecobuddy/NativePlantGardening-Pledge-5_a5xmom.png"
        ),
        
        ChallengeLocal(
            id: "16",
            challengeTitle: "Water Conservation",
            challengeDescription: "Conserve water by fixing leaks and being careful with your water usage. This helps protect Michigan's freshwater resources.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979799/Ecobuddy/MiWaterConservation-Pledge6_xqdqzq.png"
        ),
        
        ChallengeLocal(
            id: "17",
            challengeTitle: "Reduce, Reuse, Recycle",
            challengeDescription: "Practice the three Rs – Reduce, Reuse, and Recycle. Minimize waste by buying products with less packaging, reusing items like glass jars and shopping bags, and recycling materials according to  Michigan guidelines.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979802/Ecobuddy/Reduce_Reuse_Recycle-Pledge7_lqt3vm.jpg"
        ),
        
        ChallengeLocal(
            id: "18",
            challengeTitle: "Support Local Environmental Organizations:",
            challengeDescription: "Get involved with or donate to local environmental organizations in Michigan, such as the Michigan Environmental Council, or the Nature Conservancy. Check out these organizations:  River Rouge Restoration and CleanAirMI",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979803/Ecobuddy/SupportLocalEnvironmentalOrgs-Pledge8_dmfbj4.png"
        ),
        
        ChallengeLocal(
            id: "19",
            challengeTitle: "Reduce Meat Consumption",
            challengeDescription: "Choose more plant-based meals into your diet if possible. Reducing meat consumption can lower your risk of certain health issues and reduce the environmental impact associated with meat production. How about meatless Mondays? May be Vegan Wednesdays?",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979801/Ecobuddy/ReduceMeatConsumption-Pledge9_udpxew.png"
        ),
        
        ChallengeLocal(
            id: "20",
            challengeTitle: "Volunteer for Clean-up Events",
            challengeDescription: "Participate in clean-up events for places like Rouge River, Detroit River or one of Michigan’s many beaches. Not enough time? How about this - whenever you're out walking to the mailbox, going to the store or walking through a parking lot, make it a game to pick up at least one piece of litter you spot. But that's not all – score extra eco-points by tossing it in the right bin, be it recycling or trash. This hands-on effort not only improves the environment but also provides physical activity for your health.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979801/Ecobuddy/VolunteerForCleanupEvents-Pledge-10_qf6764.png"
        ),
        
        ChallengeLocal(
            id: "21",
            challengeTitle: "Use Eco-friendly Transportation",
            challengeDescription:  "If your budget allows, opt for electric or hybrid vehicles for commuting. These modes of transportation reduce greenhouse gas emissions and improve air quality.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979799/Ecobuddy/UseEcoFriendlyTransportation-Pledge11_mvclvy.png"
        ),
        //NEed to fill imageurl
        ChallengeLocal(
            id: "22",
            challengeTitle: "Proper E-Waste Disposal",
            challengeDescription: "Dispose of electronic waste (e-waste) responsibly by recycling old electronics at designated drop-off locations. Michigan has various e-waste recycling programs like those offered by EGLE to prevent toxic materials from entering landfills.",
            challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1696979803/Ecobuddy/ProperE-WasteDisposal-Pledge12_swd2kd.png"
        ),
        
        ChallengeLocal(
            id: "23",
            challengeTitle: "Air pollution 101",
            challengeDescription: "Air pollution, often originating from human activities such as industrial processes and transportation, is a pervasive issue with far-reaching consequences. This environmental challenge involves the release of harmful substances into the air, including greenhouse gases like carbon dioxide (CO2), methane (CH4), and nitrous oxide (N2O). These gases contribute significantly to global warming and climate change, disrupting weather patterns and raising temperatures worldwide. Moreover, air pollution poses a direct threat to human health, particularly in the form of respiratory illness. Exposure to pollutants such as fine particulate matter (PM2.5), ground-level ozone (O3), and volatile organic compounds (VOCs) can lead to reduced lung function, aggravation of conditions like asthma and bronchitis, and an elevated risk of chronic respiratory diseases, making it imperative to address this pressing issue for both environmental and public health reasons",
            videoURL: "https://www.youtube.com/watch?v=e6rglsLy1Ys&list=PLFB0B99D93976A52B"
        ),
        
        ChallengeLocal(
            id: "24",
            challengeTitle: "How indoor air quality affects your lung",
            challengeDescription: "Indoor air quality plays a critical role in lung health, as the air we breathe inside our homes and workplaces can contain pollutants and allergens that have a direct impact on our respiratory systems. Poor indoor air quality, characterized by high levels of airborne particles, chemicals, or mold, can lead to the development or exacerbation of lung conditions such as asthma, bronchitis, and allergies. Proper ventilation, regular maintenance, and the use of air purifiers can help improve indoor air quality and reduce the risk of respiratory issues, making it essential to prioritize clean and healthy air environments for our overall well-being.",
           videoURL: "https://www.youtube.com/watch?v=Aabz4MHXgT4"
        ),
        
        ChallengeLocal(
            id: "25",
            challengeTitle: "How to purify air quality with plants",
            challengeDescription: "Purifying air quality with plants is a natural and effective way to enhance the environment in homes and offices. Certain houseplants, such as snake plants, spider plants, and peace lilies, have been shown to absorb indoor pollutants like formaldehyde, benzene, and ammonia, thus improving air quality. These plants work by taking in these harmful substances through their leaves and roots and converting them into oxygen and water vapor. By strategically placing these air-purifying plants throughout indoor spaces, individuals can create a healthier atmosphere, reducing the risk of respiratory issues and promoting overall well-being while adding a touch of natural beauty to their surroundings..",
           videoURL: "https://www.youtube.com/watch?v=lPNYdSZRSdg"
        ),
        
        ChallengeLocal(
            id: "26",
            challengeTitle: "Understanding Asthma",
            challengeDescription: "Asthma is a common and chronic respiratory condition that can significantly impact one's quality of life. Asthma is characterized by the inflammation and narrowing of the airways, leading to symptoms like wheezing, shortness of breath, coughing, and chest tightness. Triggers for asthma attacks can vary from allergens and irritants to exercise and stress, making it important for those with asthma to identify and manage their specific triggers. Effective asthma management involves the use of inhalers or medications to control symptoms and prevent exacerbations, as well as regular monitoring and a personalized asthma action plan. By increasing awareness and education about asthma, we can empower individuals to better manage their condition, reduce the frequency and severity of symptoms, and enjoy a healthier and more active life.",
           videoURL: "https://www.youtube.com/watch?v=huf13JRr0Ao"
        ),
        
        ChallengeLocal(
            id: "27",
            challengeTitle: "Detroit advocacy groups chart a course to cleaner air",
            challengeDescription: "In Detroit, advocacy groups are at the forefront of charting a course toward cleaner air and a healthier environment for the city's residents. Recognizing the longstanding air quality challenges faced by the community, these organizations are dedicated to raising awareness, pushing for stricter environmental regulations, and promoting sustainable practices. Their efforts include advocating for reduced industrial emissions, improved public transportation, and green infrastructure projects to combat urban pollution. By collaborating with local communities and government agencies, Detroit advocacy groups are working diligently to address air quality issues, ensuring that residents can breathe cleaner air and enjoy a higher quality of life while contributing to the broader goal of environmental justice in the city.",
           challengeImage: "https://res.cloudinary.com/duiw0a1mr/image/upload/v1697669953/Ecobuddy/PlaygroundnearSteelPlant_svnpat.jpg"
        ),
        
        ChallengeLocal(
            id: "28",
            challengeTitle: "What does Air Pollution PM 2.5 do inside children's body and brain?",
            challengeDescription: "Air Pollution PM 2.5, consisting of tiny particulate matter with a diameter of 2.5 micrometers or smaller, can have detrimental effects on children's bodies and brains. When inhaled, these microscopic particles can penetrate deep into the respiratory system, causing inflammation and impairing lung function. Moreover, PM 2.5 particles can enter the bloodstream, potentially leading to systemic inflammation and cardiovascular problems. Inside the developing brains of children, exposure to PM 2.5 has been associated with cognitive deficits, reduced academic performance, and an increased risk of neurodevelopmental disorders. Furthermore, it can exacerbate conditions like asthma and lead to respiratory infections, putting children at higher health risks. Addressing air pollution, particularly reducing PM 2.5 levels, is crucial for safeguarding children's physical health and cognitive development, underscoring the urgent need for air quality improvements in urban environments and beyond.",
           videoURL: "https://www.youtube.com/watch?v=QcS3ovdsgNI&list=PLFB0B99D93976A52B&index=10"
        ),
        
        ChallengeLocal(
            id: "29",
            challengeTitle: "The legacy of the Flint water crisis",
            challengeDescription: "The legacy of the Flint water crisis serves as a stark reminder of the far-reaching consequences of environmental injustice and the failure of government institutions to protect vulnerable communities. The crisis, which unfolded in 2014 when Flint, Michigan, switched its water source to the Flint River without adequate water treatment, exposed thousands of residents, many of them low-income and predominantly African American, to lead-contaminated water. The result was a public health disaster, with elevated lead levels in children, a Legionnaires' disease outbreak, and widespread mistrust in government agencies. The legacy of this crisis includes ongoing health challenges, particularly for the children who were exposed to lead, as well as a profound loss of trust in the authorities tasked with ensuring safe drinking water. It has also sparked a nationwide conversation about environmental justice, highlighting the need for greater accountability, transparency, and equitable access to clean and safe water for all communities.",
           videoURL: "https://www.youtube.com/watch?v=GYiVHh4U4pE"
        ),
        
        ChallengeLocal(
            id: "30",
            challengeTitle: "Small town michigan students are fundraising to add 30 kw of solar to their school",
            challengeDescription: "Small-town Michigan students are taking an inspiring initiative by fundraising to add 30 kW of solar power to their school. Their dedication to renewable energy not only reflects a commitment to a greener future but also showcases the potential of grassroots efforts in rural communities. By harnessing the power of solar panels, these students are not only reducing the school's carbon footprint but also providing valuable educational opportunities for their peers, demonstrating the practicality of sustainable energy solutions. This endeavor not only benefits the environment but also instills a sense of environmental stewardship and civic engagement among the younger generation, demonstrating the positive impact that community-driven renewable energy projects can have in shaping a sustainable and eco-conscious future.",
           videoURL: "https://www.youtube.com/watch?v=2IYvvzjSDrg"
        ),
        
        ChallengeLocal(
            id: "31",
            challengeTitle: "How to Take Care of the Environment - 10 Ways to Take Care of the Environment",
            challengeDescription: "Taking care of our environment is of paramount importance because it directly impacts the well-being of our planet and future generations. Our environment provides us with essential resources like clean air, water, and fertile soil, which are vital for human survival. It also supports diverse ecosystems and biodiversity, contributing to the health of the planet as a whole. Responsible environmental stewardship helps mitigate climate change, reduces pollution, preserves natural habitats, and safeguards the health of all living beings. By protecting our environment, we ensure a sustainable future, healthier communities, and a more harmonious coexistence with the natural world. It is a collective responsibility to safeguard our environment for the benefit of ourselves and generations to come.",
           videoURL: "https://www.youtube.com/watch?v=X2YgM1Zw4_E"
        ),
        
        ChallengeLocal(
            id: "32",
            challengeTitle: "What really happens to the plastic you throw away",
            challengeDescription: "Plastic waste poses a significant threat to both environmental and human health. When plastic waste accumulates in our ecosystems, it can persist for centuries, causing harm to wildlife, marine life, and ecosystems. Plastic debris in oceans, for example, can break down into microplastics, which are ingested by marine creatures and can eventually enter the food chain, potentially reaching human consumption. The chemicals used in plastic production, such as bisphenol A (BPA) and phthalates, can leach into the environment, contaminating water and soil. Exposure to these chemicals has been linked to adverse health effects, including hormonal disruption, reproductive issues, and developmental problems. Moreover, the improper disposal of plastic waste, such as incineration or dumping in landfills, releases toxic pollutants into the air and soil, further jeopardizing human well-being. Reducing plastic waste through responsible consumption, recycling, and sustainable alternatives is essential to mitigate these health risks and protect the environment.",
           videoURL: "https://www.youtube.com/watch?v=R4MyifvlfbY"
        )
        
        
    ]
    
}

struct SubChallengesData {
    static let subChallenges: [SubChallengeLocal] = [
        SubChallengeLocal(id: "1", title: "Walk for 30 Minutes"),
        SubChallengeLocal(id: "2", title: "Explore your neighborhood on a bicycle"),
        SubChallengeLocal(id: "3", title: "Explore Nature Trails: Check out: [Nature Trails in Michigan.](https://www.metroparent.com/things-to-do/outdoors/best-places-go-hiking-southeast-michigan/)"),
        SubChallengeLocal(id: "4", title: "Share your Outdoor Selfie"),
        SubChallengeLocal(id: "5", title: "Read a book or have a cup of tea outdoors and soak up the sun"),
        SubChallengeLocal(id: "6", title: "Take a trip to the farmer's market for healthy and fresh meal inspirations"),
        SubChallengeLocal(id: "7", title: "Enjoy a family meal on your deck or in your backyard."),
        SubChallengeLocal(id: "8", title: "Spend some time gazing at the starry night sky"),
        SubChallengeLocal(id: "9", title: "Share the Story: Post your air quality story on your preferred social media platform along with the hashtag #AirQualityStory."),
        SubChallengeLocal(id: "10", title: "Promote Awareness: Research about the effects of air pollution on health, especially those with respiratory illnesses. Here is a resource to get started: [Pollution and Asthma](https://www.airnow.gov/sites/default/files/2018-03/asthma-flyer.pdf)"),
        SubChallengeLocal(id: "11", title: "Check local air quality at https://www.airnow.gov/ and make informed choices about outdoor activities and possible health impacts."),
        SubChallengeLocal(id: "12", title: "Carpool to School: Take the bus or share the ride to school with your friend at least one week."),
        SubChallengeLocal(id: "13", title: "Bike to School: Do one better and choose to bike to school instead of driving or taking the bus. Enjoy the exercise and eco-friendly commute."),
        SubChallengeLocal(id: "14", title: "Walk to Your Local ice cream store: Instead of driving, take a leisurely walk to your local ice cream store. Enjoy the fresh air and exercise while reducing your carbon footprint."),
        SubChallengeLocal(id: "15", title: "Skip the Drive and Walk to Your Friend's House: Next time you plan to visit a friend who lives nearby, leave the car at home and walk to their house. It's a healthy way to get there while helping the environment."),
        SubChallengeLocal(id: "16", title: "Visit a local Michigan Nursery or Garden Center to get an indoor plant."),
        SubChallengeLocal(id: "17", title: "Set up and care for your Plant: Find the perfect spot in your home for your new indoor plant, water it, provide it with adequate sunlight."),
        SubChallengeLocal(id: "18", title: "Share Your Plant Photos: Take pictures of your indoor plant and share them on social media using the hashtag #BreatheWithIndoorPlant. Share your thoughts on how having indoor plants can improve indoor air quality."),
        SubChallengeLocal(id: "19", title: "Daily AQI Check: Commit to checking the Air Quality Index (AQI) for your local area daily for a week"),
        SubChallengeLocal(id: "20", title: "Educate Others: Create a social media post about air quality and its impact on health, especially in Michigan to raise awareness among your followers."),
        SubChallengeLocal(id: "21", title: "Advocate for Clean Air: Reach out to local environmental organizations or authorities to discuss the importance of clean air in Michigan and advocate for measures to improve air quality."),
        SubChallengeLocal(id: "22", title: "Research Local Pollution Hotspots: Learn about areas in Michigan that may be particularly affected by pollution. Here are a couple resources to get started: [Struggling to breathe in 48217](https://www.metrotimes.com/news/struggling-to-breathe-in-48217-michigans-most-toxic-zip-code-23542211) and [Most polluted zip code in MI](https://storymaps.arcgis.com/stories/57017b1cbc9d409f9cc250e3fb4e2a9a)"),
        SubChallengeLocal(id: "23", title: "Explore Pollution Solutions: Research possible solutions that can address the pollution issues and share your thoughts using the hashtag #MIPollutionSolutions."),
        SubChallengeLocal(id: "24", title: "Engage with Local Environmental Groups: Connect with local environmental organizations or community groups working to address pollution issues. Learn about ongoing efforts and consider participating or volunteering to support their initiatives."),
        SubChallengeLocal(id: "25", title: "Advocate for Change: Consider reaching out to Michigan State representatives to advocate for actions that can help improve air quality."),
        SubChallengeLocal(id: "26", title: "Select Your Plant: Begin by choosing a plant that you would like to grow. It could be a flower, shrub, or seedling of your choice.  Check out this resource: [Plants native to Michigan.](https://www.myhomepark.com/blogs/know-native-plants/michigan-native-plants-14-amazing-landscaping-choices)"),
        SubChallengeLocal(id: "27", title: "Plant Your Chosen Greenery: Find a suitable spot in your patio or backyard to plant. Dig a hole, place your plant, and cover it with soil."),
        SubChallengeLocal(id: "28", title: "Share on Social Media: After planting your greenery, take a photo of your newly planted plant. Share this photo on your social media accounts (e.g., Facebook, Instagram, Twitter) with the hashtag #GreenItUpChallenge. In your caption, you can explain the challenge and your commitment to a greener world."),
        SubChallengeLocal(id: "29", title: "Nominate a Friend or Family Member: To further the impact, nominate a friend or family member to join the challenge."),
        SubChallengeLocal(id: "30", title: "🌳❤️💨 - \"Breathe easy with clean air! 🌬️\""),
        SubChallengeLocal(id: "31", title: "🏞️😷🚫 - \"Protect your health, say no to air pollution! 🚭\""),
        SubChallengeLocal(id: "32", title: "🌿🍃🌬️ - \"Nature's air purifiers at work! 🌱💨\""),
        SubChallengeLocal(id: "33", title: "💪🌬️ - \"Clean air, strong lungs! 💪\"")
    ]
    
    struct SubChallengeLocal {
        let id: String
        let title: String
        var status: Bool = false

        var displayOrder: Int16 {
            Int16(id) ?? 0
        }
    }
}



extension String {
    var convertUrl: URL? {
        return URL(string: self)
    }
}
