# FastForward

``` ruby
builder = FastForward.build do |ff|
  ff.input "input.avi"
  ff.output "output.avi" do |o|
    o.bitrate("64k").stream("video")
  end
end

builder.to_s # => "ffmpeg -i input.avi -b:v 64k output.avi"
```