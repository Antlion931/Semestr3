use rand::Rng;
use plotters::prelude::*;
use ordered_float::OrderedFloat;

fn draw_points(points: & Vec<(f32, f32)>, file_name: & str) -> Result<(), Box<dyn std::error::Error>>  {
   let root = BitMapBackend::new(file_name, (1920, 1080)).into_drawing_area();
    root.fill(&WHITE)?;
    
    let max = points.iter().map(|(_, f)| OrderedFloat(*f)).max().unwrap().into_inner();

    let mut chart = ChartBuilder::on(&root)
                        .x_label_area_size(30)
                        .y_label_area_size(60)
                        .build_cartesian_2d(1000f32..100_100f32, 0f32.. max*1.1)?;
    
    chart
        .configure_mesh()
        .x_labels(10)
        .y_labels(10)
        .draw()?;
    
    chart.draw_series(PointSeries::of_element(
            points.clone(),
            3,
            ShapeStyle::from(&BLUE).filled(),
            &|c, s, st| {
                EmptyElement::at(c) + Circle::new((0,0), s, st)
            },
        ))?;

    let avg = points.chunks(50).map(|r| (r[0].0, r.iter().map(|(left, right)| *right).sum::<f32>() / 50.0));
    
    chart.draw_series(PointSeries::of_element(
            avg,
            5,
            ShapeStyle::from(&RED).filled(),
            &|c, s, st| {
                EmptyElement::at(c) + Circle::new((0,0), s, st)
            },
        ))?;

    root.present()?;
    Ok(())
}

fn draw_plot(points: & Vec<(f32, f32)>, file_name: & str) -> Result<(), Box<dyn std::error::Error>>  {
   let root = BitMapBackend::new(file_name, (1920, 1080)).into_drawing_area();
    root.fill(&WHITE)?;
    
    let max = points.iter().map(|(_, f)| OrderedFloat(*f)).max().unwrap().into_inner();

    let mut chart = ChartBuilder::on(&root)
                        .x_label_area_size(30)
                        .y_label_area_size(60)
                        .build_cartesian_2d(1000f32..100_100f32, 0f32.. max*1.1)?;
    
    chart
        .configure_mesh()
        .x_labels(10)
        .y_labels(10)
        .draw()?;
    
    chart.draw_series(LineSeries::new(
            points.clone(),
            ShapeStyle::from(&BLUE).filled(),
        ))?;

    root.present()?;
    Ok(())
}

fn main() {
    let mut b_vec = Vec::with_capacity(50*100);
    let mut u_vec = Vec::with_capacity(50*100);
    let mut l_vec = Vec::with_capacity(50*100);
    let mut c_vec = Vec::with_capacity(50*100);
    let mut d_vec = Vec::with_capacity(50*100);
    let mut d_minus_c_vec = Vec::with_capacity(50*100);

    for n in (1000..=100_000).step_by(1000) {
        for _ in 0..50 {
            let mut distribution = (1..).map(|x| (x as i32, rand::thread_rng().gen_range(0..n)) );
            let mut bins = vec![0; n];
            let mut B: Option<i32> = None;
            let mut U: Option<i32> = None;
            let mut L: Option<i32> = None;
            let mut C: Option<i32> = None;  let mut at_least_one_counter = 0;
            let mut D: Option<i32> = None;  let mut at_least_two_counter = 0;
            
            while D == None {
                let (nr, r) = distribution.next().unwrap();
                bins[r] += 1;

                match bins[r] {
                    1 => at_least_one_counter += 1,
                    2 => at_least_two_counter += 1,
                    _ => {},
                }

                if nr == n as i32 {
                    U = Some(bins.iter().filter(|&&b| b == 0).count() as i32);
                    L = Some(*bins.iter().max().unwrap());
                }

                if B == None && at_least_two_counter == 1 {
                    B = Some(nr)
                }
                
                if C == None && at_least_one_counter == n {
                    C = Some(nr);
                }

                if at_least_two_counter == n {
                    D = Some(nr);
                }
            }
            b_vec.push( (n as f32 , B.unwrap() as f32) );
            u_vec.push( (n as f32 , U.unwrap() as f32) );
            l_vec.push( (n as f32 , L.unwrap() as f32) );
            c_vec.push( (n as f32 , C.unwrap() as f32) );
            d_vec.push( (n as f32 , D.unwrap() as f32) );
            d_minus_c_vec.push( (n as f32 , D.unwrap() as f32 - C.unwrap() as f32) );
        }
    }

    draw_points(&b_vec, "B.png");
    draw_points(&u_vec, "U.png");
    draw_points(&l_vec, "L.png");
    draw_points(&c_vec, "C.png");
    draw_points(&d_vec, "D.png");
    draw_points(&d_minus_c_vec, "D-C.png");
    let b_avg = b_vec.chunks(50).map(|r| (r[0].0, r.iter().map(|(left, right)| *right).sum::<f32>() / 50.0));
    let u_avg = u_vec.chunks(50).map(|r| (r[0].0, r.iter().map(|(left, right)| *right).sum::<f32>() / 50.0));
    let l_avg = l_vec.chunks(50).map(|r| (r[0].0, r.iter().map(|(left, right)| *right).sum::<f32>() / 50.0));
    let c_avg = c_vec.chunks(50).map(|r| (r[0].0, r.iter().map(|(left, right)| *right).sum::<f32>() / 50.0));
    let d_avg = d_vec.chunks(50).map(|r| (r[0].0, r.iter().map(|(left, right)| *right).sum::<f32>() / 50.0));
    let d_minus_c_avg = d_minus_c_vec.chunks(50).map(|r| (r[0].0, r.iter().map(|(left, right)| *right).sum::<f32>() / 50.0));

    draw_plot(&b_avg.clone().map(|(n, v)| (n, v/n) ).collect::<Vec<_>>(), "b_n.png");
    draw_plot(&b_avg.clone().map(|(n, v)| (n, v/n.sqrt()) ).collect::<Vec<_>>(), "b_sqrt(n).png");
    draw_plot(&u_avg.clone().map(|(n, v)| (n, v/n) ).collect::<Vec<_>>(), "u_n.png");
    draw_plot(&l_avg.clone().map(|(n, v)| (n, v/n.ln()) ).collect::<Vec<_>>(), "l_ln(n).png");
    draw_plot(&l_avg.clone().map(|(n, v)| (n, v*n.ln().ln()/n.ln()) ).collect::<Vec<_>>(), "l_ln(n)_lnln(n).png");
    draw_plot(&l_avg.clone().map(|(n, v)| (n, v/n.ln().ln()) ).collect::<Vec<_>>(), "l_lnln(n).png");
    draw_plot(&c_avg.clone().map(|(n, v)| (n, v/n) ).collect::<Vec<_>>(), "c_n.png");
    draw_plot(&c_avg.clone().map(|(n, v)| (n, v/(n * n.ln() ))).collect::<Vec<_>>(), "c_n_ln(n).png");
    draw_plot(&c_avg.clone().map(|(n, v)| (n, v/n.powf(2.0)) ).collect::<Vec<_>>(), "c_pow(n, 2).png");
    draw_plot(&d_avg.clone().map(|(n, v)| (n, v/n) ).collect::<Vec<_>>(), "d_n.png");
    draw_plot(&d_avg.clone().map(|(n, v)| (n, v/(n * n.ln()) )).collect::<Vec<_>>(), "d_n_ln(n).png");
    draw_plot(&d_avg.clone().map(|(n, v)| (n, v/n.powf(2.0)) ).collect::<Vec<_>>(), "d_pow(n, 2).png");
    draw_plot(&d_minus_c_avg.clone().map(|(n, v)| (n, v/n) ).collect::<Vec<_>>(), "d-c_n.png");
    draw_plot(&d_minus_c_avg.clone().map(|(n, v)| (n, v/(n * n.ln()) )).collect::<Vec<_>>(), "d-c_n_ln(n).png");
    draw_plot(&d_minus_c_avg.clone().map(|(n, v)| (n, v/(n * n.ln().ln()) )).collect::<Vec<_>>(), "d-c_lnln(n).png");
}
